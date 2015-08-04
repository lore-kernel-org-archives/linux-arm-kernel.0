From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 4 Aug 2015 17:36:55 +0100
Subject: [Xen-devel] [PATCH 1/8] arm/xen: Remove helpers which are PV
 specific
In-Reply-To: <1438340142.30740.57.camel@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-2-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507311142580.11337@kaball.uk.xensource.com>
 <1438340142.30740.57.camel@citrix.com>
Message-ID: <55C0EA27.60608@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31/07/15 11:55, Ian Campbell wrote:
>>> +/* Only used in PV code. However ARM guest is always assimilated as 
>>> HVM. */
>>                                ^ "However" doesn't make sense here from an
>>                                english grammer point of view.
> 
> "English grammar" :-P
> 
> Sorry. What I really meant to say was that "assimilated" doesn't make sense
> in this context either. I think maybe what was meant is "ARM guests are
> always HVM".

Yes. I will update the commit message too.

Regards,

-- 
Julien Grall
