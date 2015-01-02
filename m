From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Fri, 02 Jan 2015 10:46:54 -0800
Subject: [PATCH V2 0/2] ARM: l2c: OMAP4/AM437x: Additional register
 programming support.
In-Reply-To: <1420220628-23742-1-git-send-email-nm@ti.com>
References: <1420220628-23742-1-git-send-email-nm@ti.com>
Message-ID: <54A6E79E.7010203@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/2/15 9:43 AM, Nishanth Menon wrote:
> Hi,
> OMAP4 and AM437x ROM code provides services to program PL310's latency
> registers and AM437x provides service for programming Address filter
> registers.
>
> Provide support in the kernel for the same.
>
> V2 of the series contains documentation update and a bug fix due to a
> typo introduced during patch split :(
>
> Nishanth Menon (2):
>    ARM: l2c: OMAP4/AM437x: Introduce support for cache latency
>      programming
>    ARM: l2c: AM437x: Introduce support for cache filter programming
>
Looks fine to me ...
Feel free to add my ack if you need one ...

Minor: The subject looks like I2C though it is L2C ;-)
