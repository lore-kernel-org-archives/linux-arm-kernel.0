From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jan 2012 18:17:25 -0800
Subject: [PATCH v1 1/3] ARM: tegra: definitions for flow controller
In-Reply-To: <1327594923-21822-2-git-send-email-pdeschrijver@nvidia.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
 <1327594923-21822-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAOesGMghrFvCzyTaLfeF5RB77UUxpzEQj+j5Ega_uzL1SdbrOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 26, 2012 at 8:22 AM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> Introduce some definitions for the tegra flow contoller. This will be
> used by the code which controls entering and leaving LP3.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Do you expect to use these defines anywhere else than in the sleep.S
in the near future? If not, please just move them over to that file.

-Olof
