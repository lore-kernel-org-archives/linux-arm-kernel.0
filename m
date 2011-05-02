From: viktor.rosendahl@nokia.com (Viktor Rosendahl)
Date: Mon, 02 May 2011 19:35:16 +0300
Subject: Patch 6853/1 incorrectly moved to superseeded ?
Message-ID: <4DBEDD44.7040509@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I got a message that you moved my patch "Patch 6853/1: Fix ldrd/strd 
emulation for kprobes" to superseeded based on the assumption that it 
would have been superseeded by John Medhurst's patch "ARM: kprobes: Fix 
emulation of LDRD and STRD instructions".

However, when I look at John's patch, it seems to me that his patch is 
supposed to sit on top of my patch, not to replacing it.

Nicolas and Tixy, feel free to correct me if I am wrong.

best regards,

Viktor
