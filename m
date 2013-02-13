From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 13 Feb 2013 13:38:07 +0200
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <511A7AB5.4040607@wwwdotorg.org>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
 <1360580700-10245-9-git-send-email-pdeschrijver@nvidia.com>
 <511A7AB5.4040607@wwwdotorg.org>
Message-ID: <20130213113807.GE3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 06:24:05PM +0100, Stephen Warren wrote:
> On 02/11/2013 04:04 AM, Peter De Schrijver wrote:
> > Add references to tegra_car clocks for the basic device nodes.
> 
> In this patch, you also need to remove the "clock-frequency" properties
> from tegra114-*.dts board files.

That would probably break bisectability no? I think this needs to be done
in a separate patch. Also, the UARTD enabling in init_table[] can then be
removed.

Cheers,

Peter.
