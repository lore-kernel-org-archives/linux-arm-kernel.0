From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Wed, 29 Oct 2014 16:47:01 +0300
Subject: [PATCH v5 0/3] Add Phytec pbab01 audio support
Message-ID: <1414590424-25585-1-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By mistake previous patchset versions was sent as in-reply-to to
previous patchset versions, so they may have been lost among other
mails.

One of pathces was already applied by Mark Brown, here is 3 patches
implementing audio support on Phytec phyFLEX-i.MX6 boards.

This patchset version only renames audio card name to
OnboardTLV320AIC3007 (on request from Phytec).

Patches are based on branch for-next of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
