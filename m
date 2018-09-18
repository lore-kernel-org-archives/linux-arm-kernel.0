From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 18 Sep 2018 12:18:54 +0100
Subject: [GIT PULL] ARM: dts: vexpress: update for v4.20
Message-ID: <1537269535-26081-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

I am also sending the patch along with this PR in case you want to avoid
single patch merge. Please pull the tag or the patch.

Regards,
Sudeep

--

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-updates-4.20

for you to fetch changes up to 1435696556e46a7dc22a4b2fb1a9a68ae75591c2:

  ARM: dts: vexpress/TC2: Update entries to match latest coresight bindings (2018-09-11 18:25:07 +0100)

----------------------------------------------------------------
ARMv7 Vexpress updates for v4.20

Single patch to use updated coresight graph bindings thereby removing
loads of dtc warnings

----------------------------------------------------------------
Suzuki K Poulose (1):
      ARM: dts: vexpress/TC2: Update entries to match latest coresight bindings

 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 94 ++++++++++++++++--------------
 1 file changed, 49 insertions(+), 45 deletions(-)
