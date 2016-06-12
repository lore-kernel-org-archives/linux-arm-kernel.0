From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Mon, 13 Jun 2016 01:04:15 +0200
Subject: [PATCH v2 1/2] ARM: dts: imx6q-cm-fx6: fix the operation points
In-Reply-To: <c961c1e0cdde471daf1bdce2e8e7696b@rwthex-s2-a.rwth-ad.de>
References: <cd3010c3a4144ec38f2cfd1bfbd1b2ad@rwthex-s1-b.rwth-ad.de>
 <c961c1e0cdde471daf1bdce2e8e7696b@rwthex-s2-a.rwth-ad.de>
Message-ID: <333d8139fc75434e87b49a479c91fd60@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

thanks again for your review!

On 06/13/2016 12:49 AM, Fabio Estevam wrote:
> On Sun, Jun 12, 2016 at 12:19 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
> 
>> +&cpu0 {
>> +       /* Although the imx6q fuse indicates that 1.2GHz operation is possible,
>> +        * the module behaves unstable at this frequency. Hence, remove the
>> +        * 1.2GHz operation point here.
>> +        */
> 
> Just one minor comment.
> 
> From Documentation/CodingStyle:
> 
> "The preferred style for long (multi-line) comments is:
> 
>     /*
>      * This is the preferred style for multi-line
>      * comments in the Linux kernel source code.
>      * Please use it consistently.
>      *
>      * Description:  A column of asterisks on the left side,
>      * with beginning and ending almost-blank lines.
>      */
> "
> 
ups, I took only a quick look and picked the comment style for net/ ...
I will fix it and read more carefully next time.

Thanks,
Christopher

> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
