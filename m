From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2011 15:30:21 -0800
Subject: [PATCH v2 1/2] Add initial support for the Toshiba AC100/Dynabook
	AZ netbook
In-Reply-To: <2717b8b15dfde5e2db0eed4c9b89dd8d4fee5e68.1299526691.git.marvin24@gmx.de>
References: <cover.1299526691.git.marvin24@gmx.de>
	<2717b8b15dfde5e2db0eed4c9b89dd8d4fee5e68.1299526691.git.marvin24@gmx.de>
Message-ID: <AANLkTikjV2XtXo7sZ0J2VtLQG4LAiNcb8wBFuc8qu=jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2011 at 12:01 PM, Marc Dietrich <marvin24@gmx.de> wrote:
> This patch adds the config infrastructure, the pinmux and basic
> board setup code for PAZ00 (name of board inside the AC100/AZ).
>
> Signed-off-by: Marc Dietrich <marvin24@gmx.de>

Thanks, looks good. Picked up in boards-for-next for .39, I don't see
a reason to not merge it earlier than .40.

I sqashed the config change in with my defconfig update.


-Olof
