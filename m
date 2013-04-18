From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 18 Apr 2013 14:45:35 +0100
Subject: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
In-Reply-To: <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
Message-ID: <20130418134535.5189E3E1319@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Apr 2013 11:18:28 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
> This patch converts the pci_load_of_ranges function to use the new common
> of_pci_range_parser.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Looks okay to me, and thank you very much for doing the legwork to merge
the common code.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
