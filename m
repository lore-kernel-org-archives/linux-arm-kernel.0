From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 20:10:37 +0100
Subject: [PATCH] CNS3xxx: remove unused *_VIRT definitions
In-Reply-To: <m3twkqocy1.fsf@t19.piap.pl>
References: <m3y4a2od0j.fsf@t19.piap.pl> <m3twkqocy1.fsf@t19.piap.pl>
Message-ID: <3497977.bq3igK6eXq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 March 2016 08:49:10 Krzysztof Ha?asa wrote:
> Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
> 

Applied to next/fixes-non-critical, with this changelog
added:

commit 59e430525b1f966edf2573256d78bf63c7561433
Author: Krzysztof Ha?asa <khalasa@piap.pl>
Date:   Tue Mar 1 08:49:10 2016 +0100

    CNS3xxx: remove unused *_VIRT definitions
    
    All PCI mmio ranges are dynamically mapped now, so we
    can remove the fixed virtual address definitions.
    
    Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
