From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 20 Mar 2015 18:47:18 +0300
Subject: [PATCH] ARM: trusted_foundations: Maintain CPU endianness
In-Reply-To: <1426865807-22981-1-git-send-email-digetx@gmail.com>
References: <1426865807-22981-1-git-send-email-digetx@gmail.com>
Message-ID: <550C4106.4090801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch not tested. I assume that firmware save/restore cp15 context, i.e. it 
doesn't require switching to LE before smc call and restore endianness after.

-- 
Dmitry
