From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 2 Feb 2016 18:05:49 +0000
Subject: [PATCH 08/11] clk: sunxi: improve error reporting for the mux
 clock
In-Reply-To: <20160202180227.GC4652@lukather>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-9-git-send-email-andre.przywara@arm.com>
 <20160202180227.GC4652@lukather>
Message-ID: <56B0EFFD.8070900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut,

On 02/02/16 18:02, Maxime Ripard wrote:
> On Mon, Feb 01, 2016 at 05:39:27PM +0000, Andre Przywara wrote:
>> clk_register_mux returns a pointer wrapped error value in case of
>> failure, so a simple NULL check is not sufficient to catch errors.
>> Fix that and elaborate on the failure reason on the way. The whole
>> function does not return any error value, so silently failing may
>> leave users scratching their heads because the kernel does not
>> provide any clues on what's wrong.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Applied, thanks.
> 
> Any chance you do that for the other functions? :)

Sure, that was actually a test balloon ;-)

Cheers,
Andre
