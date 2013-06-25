From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Jun 2013 18:44:19 +0200
Subject: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <CAErSpo67ogc6R=vk+dt0Y6OFvwtLTL57tHx1u1zTkqY9g4N_1w@mail.gmail.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130620185707.GA8888@mithrandir>
 <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
 <20130625115552.7ebdad17@skate>
 <CAErSpo67ogc6R=vk+dt0Y6OFvwtLTL57tHx1u1zTkqY9g4N_1w@mail.gmail.com>
Message-ID: <20130625184419.2bc14a71@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Tue, 25 Jun 2013 10:20:33 -0600, Bjorn Helgaas wrote:

> > Any suggestion on how to solve this particular case?
> 
> Nope.  Just leave it as-is for that case and consolidate what you can.

So I keep the weak arch_*() function and the strong default_*() for
this particular hook, and for all the other hooks, I only keep a weak
arch_*() function. Is this what you suggest for now?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
