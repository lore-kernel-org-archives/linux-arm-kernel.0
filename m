From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sat, 3 Nov 2012 08:39:20 +0000
Subject: [RFC 00/15] Add basic suspend-resume support for AM33XX
In-Reply-To: <50944655.20602@gmail.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <50944655.20602@gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFE615@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Sat, Nov 03, 2012 at 03:46:53, Daniel Mack wrote:
[...]
> 
> What event did you use to bring the system back to life? I tried a GPIO
> button which has "linux,wakeup" set and is connected to GPIO bank 0, but
> without success.

I used uart wakeup in my testing. I see that you have CPSW driver also
in your kernel. Can you try with a minimal set of drivers, similar to what
BeagleBone has on Tony's master branch right now.
 
Mugunthan mentioned he has a fix of the WARN_ON from CPSW driver that you
see in the logs and that will be posted shortly. Can you mention what other
patches you have pulled in?

Regards,
Vaibhav
