From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Jan 2016 13:39:23 -0800
Subject: [PATCH 00/13] dtb: amd: Miscelleneous Updates for AMD Seattle DTS
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <CAOesGMgRC2vTVdmY6kKYonM1JkWD=-3k_EQ4hGvyrm-vNZczrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suravee,

On Wed, Jan 27, 2016 at 1:11 PM, Suravee Suthikulpanit
<Suravee.Suthikulpanit@amd.com> wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>
> This patch series contains several updates for the AMD Seattle SOC DTS files.
> It also adds new board files for newer Overdrive and Linaro 96boards (Husky)
> platforms.

My Overdrive comes with DT provided by firmware, so there's no need to
have a in-kernel-tree DT source.

Are you aware of other reasons to have it here? I just foresee
divergence and conflicts between the two. It was quite obvious before
this update when the FW-provided DT was a lot more complete than what
we had in the kernel tree.


-Olof
