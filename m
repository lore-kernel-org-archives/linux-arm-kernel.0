From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon,  1 Jul 2013 12:03:58 +0100
Subject: v3.10 - big endian core support
Message-ID: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest big-endian changes, now on:

	git://git.baserock.org/delta/linux baserock/311/be/core

This has a minor fix from the last version where a rebase missed a change
in the smp_scu code.
