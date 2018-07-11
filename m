From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 11 Jul 2018 13:00:34 +0200
Subject: [PATCH 0/3] arm: covert a few locks to raw_spin_lock_t
Message-ID: <20180711110037.12928-1-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a repost. The only change since the last post happend in 1/3
were I added two additional boot_lock user.
This raw_spin_lock_t changes were identified under PREEMP_RT.

Sebastian
