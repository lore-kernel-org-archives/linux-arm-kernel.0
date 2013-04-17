From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 18 Apr 2013 02:29:16 +0400
Subject: [PATCH 3/4] ARM: shmobile: Marzen: add VIN and ADV7180 support
In-Reply-To: <201304180215.01218.sergei.shtylyov@cogentembedded.com>
References: <201304180206.39465.sergei.shtylyov@cogentembedded.com>
 <201304180215.01218.sergei.shtylyov@cogentembedded.com>
Message-ID: <516F223C.2010704@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/18/2013 02:15 AM, Sergei Shtylyov wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>
> Add ADV7180 platform devices on the Marzen board, configure VIN1/3 pins, and
> register VIN1/3 devices with the ADV7180 specific platform data.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>   arch/arm/mach-shmobile/board-marzen.c |   55 ++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)

    Oops, should have updated copyrights on this file. :-/
    Well, this is probably not the last version of the patchset 
anyway... :-)

WBR, Sergei
