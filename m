From: horms@verge.net.au (Simon Horman)
Date: Mon, 12 Oct 2015 08:55:40 +0900
Subject: [PATCH] ARM: shmobile: henninger: add MSIOF0 DT support
In-Reply-To: <56182654.6070205@cogentembedded.com>
References: <201405070048.00213.sergei.shtylyov@cogentembedded.com>
 <56182654.6070205@cogentembedded.com>
Message-ID: <20151011235540.GB20025@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 11:40:52PM +0300, Sergei Shtylyov wrote:
> On 05/07/2014 12:47 AM, Sergei Shtylyov wrote:
> 
> >Define the Henninger board dependent part of the MSIOF0 device node.
> >Add device node for Renesas R2A11302FT PMIC for which no bindings exist yet.
> 
>    I've just realized that there's no such PMIC on the Henninger/Porter
> boards and MSIOF0 is only connected to CN6, hence this patch was wrong.
> The .dts is going to be deleted anyway though...

Feel free to send an incremental update to the henninger if you
want to clean this up before removing the file entirely.

> >Based on the Koelsch MSIOF device tree patch by Geert Uytterhoeven.
> >
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> MBR, Sergei
> 
