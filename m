From: xerofoify@gmail.com (Nick Krause)
Date: Sun, 20 Jul 2014 00:27:37 -0400
Subject: Edma.c: Fix Mes
Message-ID: <CAPDOMVhd-mfNfT+DbHWbzQA8sb3xpqW6a0WEuTTeCGyK8+kRNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Russell and others,
Sorry to bug you again but I have a fix questions before I clean up
the fix mes in this file.
Is edma_clean_channel needed or is edma_stop good enough?  And do  we
CCERR.BIT(16)
need to write this bit or not?
Cheers Nick
