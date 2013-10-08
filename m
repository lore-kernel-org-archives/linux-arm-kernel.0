From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  9 Oct 2013 00:34:16 +0200
Subject: New big-endian patch series against 3.12-rc4
Message-ID: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new series for big-endian on ARM re-based onto 3.12-rc4
and updated with new patches from Victor to fix regressions since 3.11.

I have not been able to test this further than building it as I do not
currently have access to any hardware, however there where no big issues
when re-basing. Thanks to Marc Zyngier for pointing out the need for a
rebase.

The branch is at:

  git://git.baserock.org/delta/linux baserock/bjdooks/3.12-rc4/core

Russell, if possible could this go into -next and then if everything
I can issue a pull request for it.

Changes since last:

- Updated to 3.12-rc4 to be closer to mainline
- Added Victor's patches for CCI and TC2 boot
- Added Victor's patch for ASID extraction
- Updated Victor's patch with fix for building on older kernels
