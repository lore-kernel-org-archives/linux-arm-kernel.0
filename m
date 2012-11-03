From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sat, 3 Nov 2012 14:03:14 +0000
Subject: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
In-Reply-To: <50951F22.1070904@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
 <50950AC7.1030707@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
 <50951F22.1070904@deeprootsystems.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFEBAE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 19:11:54, Kevin Hilman wrote:
[...]
> 
> Yes, please try with that.  Won't that be necessary anyways for situations
> where the powerdomain goes off?
> 

Yes, we probably got lucky with the minimal resume routine.

Regards,
Vaibhav 
