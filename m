From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 15:15:01 +0000
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129161211.7bb8cada@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129161211.7bb8cada@skate>
Message-ID: <20130129151501.GY23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 04:12:11PM +0100, Thomas Petazzoni wrote:
> Russell,
> 
> As the arch/arm/kernel/ maintainer, what is your position regarding the
> below patch?

Given the description, I'd feel much happier with this if we specified
the alignment numerically rather than allowing "some random code" to do
something with the passed values.
