From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Nov 2013 18:37:03 +0000
Subject: [RFC] kprobes/kprobes-test fixes, .inst updates
Message-ID: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series to fix kprobes and kprobes-test, as well as tidy
up the <asm/opcodes.h> use of data instructions to output code and
a missed bug in traps.

I have not had time to test these, or push to the new git server we
are using. I will try and sort this out on monday.

This is an initial review series and I would appreicate testing.
