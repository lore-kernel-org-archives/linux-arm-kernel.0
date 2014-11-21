From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 21 Nov 2014 17:40:12 +0530
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache
 save
In-Reply-To: <20141120144028.GB5809@localhost.localdomain>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com> <20141120144028.GB5809@localhost.localdomain>
Message-ID: <546F2BA4.4000808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 08:10 PM, Richard Cochran wrote:
> On Thu, Nov 20, 2014 at 07:26:00PM +0530, Sekhar Nori wrote:
>> I tested this using lcd7 cape connected to beaglebone black. The latest
>> kernel I could find on this board was a TI BSP based v3.14 kernel. So I
>> had to port these patches to that kernel. Cc Robert Nelson to see if he
>> knows about a more recent kernel supporting that cape.
> 
> What is missing from mainline for the black?
> 
> (I thought it was fully supported by now.)

Black is supported, but LCD7 cape is not.

>  
>> I did not see any breakage with these patches applied although I did not
>> see any noticeable performance improvement as well.
> 
> So, the jumping on pen-up persists, right?  That means the patch
> series does not provide a general fix for that issue.

Not sure how to reproduce the jumping on pen-up. I was able to draw
circles, sign my name and actually today I wrote up the whole English
alphabet on the screen. Picture here.

https://drive.google.com/file/d/0ByWLwvGx8MeyVF9CTlhHU0FHMFk/view?usp=sharing

Is there any particular pattern you want me to test with?

I would still like to test with a more recent kernel on LCD7 cape. So,
if anyone has ideas (other than I porting the LCD7 support) please let
me know.

Thanks,
Sekhar
