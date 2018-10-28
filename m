From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 28 Oct 2018 22:02:32 +0100 (CET)
Subject: [PATCH RFC 16/18] staging: vchiq_arm: rework probe and init
 functions
In-Reply-To: <20181026134813.7775-17-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-17-nsaenzjulienne@suse.de>
Message-ID: <437901663.4228.1540760552985@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> Some operations performed in the probe function should have been
> implemented in the init function. Namely class and dev region creations.
> 

Please explain the why in the commit log
