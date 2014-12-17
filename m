From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 17 Dec 2014 17:06:54 +0900
Subject: [PATCH v6 0/3] Add gpio support to Broadcom Cygnus SoC
In-Reply-To: <1418696307-19392-1-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1418696307-19392-1-git-send-email-rjui@broadcom.com>
Message-ID: <CAAVeFuKYDVdMYqHRij2U3fDQUOhwa8-OYDb4ZNkXevX+qWy04Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 11:18 AM, Ray Jui <rjui@broadcom.com> wrote:
> This patchset contains the initial GPIO support for the Broadcom Cygnus SoC.
> Cygnus has 3 GPIO controllers: 1) the ASIU GPIO; 2) the chipCommonG GPIO;
> and 3) the ALWAYS-ON GPIO. All 3 types of GPIO controllers are supported by
> the same Cygnus GPIO driver

No objections for this v6. The series,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
