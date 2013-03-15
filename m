From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 15 Mar 2013 17:46:57 +0100
Subject: [PATCH 2/3] mfd: Make AB8500_CORE select POWER_SUPPLY to fix
 build error
In-Reply-To: <201303151018.13518.arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-2-git-send-email-arnd@arndb.de>
 <20130315064436.GD12559@zurbaran>
 <201303151018.13518.arnd@arndb.de>
Message-ID: <20130315164657.GA29606@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Mar 15, 2013 at 10:18:13AM +0000, Arnd Bergmann wrote:
> On Friday 15 March 2013, Samuel Ortiz wrote:
> > On Thu, Mar 14, 2013 at 10:56:39PM +0100, Arnd Bergmann wrote:
> > > 
> > > Please apply to MFD tree for 3.9
> > Already applied to mfd-fixes.
> > 
> 
> For some reason I did not see it when I rebased my patches on top of linux-next
> to make sure I don't send any patches again that are already queued up.
> 
> Is there a reason why mfd-fixes is not part of linux-next?
No valid reasons, you're right. I'll ping Stephen about it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
