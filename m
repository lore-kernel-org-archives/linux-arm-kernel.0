From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Jul 2013 23:45:01 +0200
Subject: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
In-Reply-To: <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
Message-ID: <20130705234501.1341f52e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Fri, 5 Jul 2013 15:37:33 -0600, Bjorn Helgaas wrote:

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Again, please update the subject line to "PCI: Remove ..."
> 
> I doubt that you'll get explicit acks from all the arches you touched,
> but I think it's reasonable to put at least patches 2 & 3 in -next
> soon after v3.11-rc1, so we should have time to shake out issues.

Sure. Which merge strategy do you suggest for this patch series, which
touches a number of different areas, and has some build-time
dependencies between the patches (if needed, I can detail those build
time dependencies to help figuring out the best strategy).

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
