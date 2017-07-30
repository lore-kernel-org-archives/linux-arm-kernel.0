From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 30 Jul 2017 07:32:56 -0700
Subject: [PATCH 4/9] serial: stm32: fix pio transmit timeout
In-Reply-To: <1499958494-19354-5-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
 <1499958494-19354-5-git-send-email-bich.hemon@st.com>
Message-ID: <20170730143256.GA30584@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 03:08:28PM +0000, Bich HEMON wrote:
> From: Gerald Baeza <gerald.baeza@st.com>
> 
> 100?s was too short for low speed transmission
> (9600bps)
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch did not apply :(
