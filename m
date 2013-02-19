From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 16:32:15 +0530
Subject: [PATCH, RFC 4/8] ARM: am33xx: ll debug config help
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA867A@DBDE01.ent.ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <bfe941adb98a5000c2817f9fd6160070e59e53c9.1361186097.git.afzal@ti.com>
 <51235337.60209@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EAA867A@DBDE01.ent.ti.com>
Message-ID: <51235BB7.2050600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013 04:00 PM, Mohammed, Afzal wrote:
> Hi Santosh,
>
> On Tue, Feb 19, 2013 at 15:55:59, Shilimkar, Santosh wrote:
>
>> With DT, IIRC DEBUGLL is broken. So did you hack debug-macro.S
>> to get the earlyprintk working ?
>
> No, on linux-next, ll debug works properly.
>
Indeed. Tony fixed that now. Some how I missed
this patch on the list.

Regards,
Santosh
