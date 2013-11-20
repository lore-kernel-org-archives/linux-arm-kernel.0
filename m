From: lho@apm.com (Loc Ho)
Date: Tue, 19 Nov 2013 16:08:42 -0800
Subject: [PATCH v2 4/4] arm64: Add APM X-Gene SoC 6.0Gbps SATA PHY DTS
 entries
In-Reply-To: <1384905197-3566-5-git-send-email-lho@apm.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <1384905197-3566-2-git-send-email-lho@apm.com>
 <1384905197-3566-3-git-send-email-lho@apm.com>
 <1384905197-3566-4-git-send-email-lho@apm.com>
 <1384905197-3566-5-git-send-email-lho@apm.com>
Message-ID: <CAPw-ZTm8a2jj1ggu0wBgEgaZFphTpAsSROXE0_BjQFqH12crYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi,

> +                       txbooster = <0x2 0x2 0x2 0x2 0x2 0x2>;
> +                       txskew = <0xa 0xa 0xa 0xa 0xa 0xa>;
[Loc Ho]
These isn't correct. They should be txboostgain and txeyetuning. I
will fix these in the next version.

-Loc
