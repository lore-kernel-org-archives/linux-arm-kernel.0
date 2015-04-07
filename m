From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 7 Apr 2015 09:14:10 +0200
Subject: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
In-Reply-To: <1428258294.2775.69.camel@perches.com>
References: <1428169665.2775.53.camel@perches.com>	
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
Message-ID: <552383C2.3050502@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 04/05/2015 08:24 PM, Joe Perches wrote:
> These structs can be const, so make them const.
>
> Miscellanea:
>
> o Add static to struct uart_ops declaration in bfin_sport_uart
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
[...]

for
>   drivers/tty/serial/st-asc.c                 | 2 +-

Acked-by: Patrice Chotard <patrice.chotard@st.com>


Thanks
