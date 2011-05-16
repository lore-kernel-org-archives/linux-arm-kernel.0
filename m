From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 16 May 2011 16:56:59 +0530
Subject: [PATCH resend] spi/amba-pl022: work in polling or interrupt	mode
	if pl022_dma_probe fails
In-Reply-To: <20110516110438.GP30539@n2100.arm.linux.org.uk>
References: <052261410dd8d224fc199518e646abf80bfa7d4c.1305518921.git.viresh.kumar@st.com>
	<20110516110438.GP30539@n2100.arm.linux.org.uk>
Message-ID: <4DD10A03.2090204@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2011 04:34 PM, Russell King - ARM Linux wrote:
> On Mon, May 16, 2011 at 09:40:10AM +0530, Viresh Kumar wrote:
>> > If pl022_dma_probe fails, we can try to transfer data in polling or interrupt
>> > mode. Also, set platform_info->enable_dma to 0, so that no other code tries to
>> > use dma.
>> > 
>> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Shouldn't this go via the SPI people rather than my tree?

This can, but i have seen amba drivers patches going through your
drivers branch, so sent to tracker. Should i get them through spi-devel??

-- 
viresh
