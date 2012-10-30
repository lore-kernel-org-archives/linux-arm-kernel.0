From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 30 Oct 2012 22:34:32 +0100
Subject: [PATCH 2/4] net: cpsw: Add parent<->child relation support
 between cpsw and mdio
In-Reply-To: <1351498881-32482-4-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Mon, 29 Oct 2012 13:51:19 +0530")
References: <1351498881-32482-1-git-send-email-hvaibhav@ti.com>
 <1351498881-32482-4-git-send-email-hvaibhav@ti.com>
Message-ID: <87390vhcev.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> CPGMAC SubSystem consist of various sub-modules, like, mdio,
 Vaibhav> cpdma, cpsw, etc... These sub-modules are also used in some of
 Vaibhav> Davinci family of devices. Now based on requirement, use-case
 Vaibhav> and available technology nodes the integration of these
 Vaibhav> sub-modules varies across devices.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
