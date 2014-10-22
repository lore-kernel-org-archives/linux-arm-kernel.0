From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 Oct 2014 15:13:05 -0200
Subject: [PATCH] ARM: mx6: Fix suspend/resume with PCI
In-Reply-To: <CAOMZO5DB2bwAPf5CVGmaY2no_620DhSvN2-w=BKJRZ3cjQw_Ew@mail.gmail.com>
References: <1407371998-11437-1-git-send-email-festevam@gmail.com>
 <E1XYuVl-0006Jx-Mh@bombadil.infradead.org>
 <CAOMZO5DB2bwAPf5CVGmaY2no_620DhSvN2-w=BKJRZ3cjQw_Ew@mail.gmail.com>
Message-ID: <CAOMZO5CJG=B6=cwD2HRz5VYFP3Sq=+VLNUAOBd9zFJGVS32zHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bj?rn,

On Tue, Sep 30, 2014 at 8:42 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Thanks for testing.
>
> This is a workaround found on FSL kernel. We still need to come up
> with a proper fix for this PCI suspend/resume issue.

Just tried 3.18.0-rc1 and I don't see this PCI suspend/resume hang
anymore on a mx6qsabresd revC2 with silicon TO1.2.

It does hang on an old mx6sabresd revB with TO1.1 silicon though.

Can you try with 3.18-rc1?
