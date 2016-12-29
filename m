From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Dec 2016 18:22:54 -0200
Subject: [PATCH 4/6] ARM: mach-mx35_3ds: Remove camera support
In-Reply-To: <CAM=E1R4a6Qd1ib-cmRi4PzuDXPDwLEarHOxc6aDDVLDZcWvVeQ@mail.gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
 <1482756987-12414-4-git-send-email-festevam@gmail.com>
 <CAM=E1R64X6o0o604gGiU4+uQ6W_PUSbzgpaAYWSYEiSz_D8uGQ@mail.gmail.com>
 <CAOMZO5CF8QiJ21VbJCs4nj-WiAnfhsU0v7XpLGM3rcN1GoPiMQ@mail.gmail.com>
 <CAM=E1R4a6Qd1ib-cmRi4PzuDXPDwLEarHOxc6aDDVLDZcWvVeQ@mail.gmail.com>
Message-ID: <CAOMZO5AYMoT58YeOnF2U-07Wp+ENf2308ozDY=oO+MLwd4zCRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 5:07 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:

> Ok, good, so vcam is used for something else than camera then?

Yes, vcam is used to power de sgtl5000 codec:

static struct regulator_consumer_supply vcam_consumers[] = {
/* sgtl5000 */
REGULATOR_SUPPLY("VDDA", "0-000a"),
};
