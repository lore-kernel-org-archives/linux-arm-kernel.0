From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Jul 2015 09:09:50 +0200
Subject: [PATCH v2 1/2] dmaengine: Add an enum for the dmaengine
 alignment constraints
In-Reply-To: <20150727064804.GN2564@lukather>
References: <1437381693-18948-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150720110325.502af335@free-electrons.com>
 <20150727064804.GN2564@lukather>
Message-ID: <20150727090950.37122de2@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

On Mon, 27 Jul 2015 08:48:04 +0200, Maxime Ripard wrote:

> I could, but all the rest of the other similar case so far in
> dmaengine are made through enum, so I guess it's still better for
> consistency. And we also provide a comprehensive list of the valid
> values this way, something a function would not provide (or at least
> not at compilation time)

Alright, makes sense.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
