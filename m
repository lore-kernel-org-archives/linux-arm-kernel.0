From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 12:10:47 +0000
Subject: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
In-Reply-To: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
Message-ID: <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/01/18 11:54, Julien Thierry wrote:
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
> 


I have submitted a separate series making use of this feature for the 
ARM PMUv3 interrupt [1].

[1] https://www.spinics.net/lists/arm-kernel/msg629402.html

Cheers,

-- 
Julien Thierry
