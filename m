From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 20 Jul 2017 13:39:33 +0100
Subject: [PATCH 2/2] net: ethernet: nb8800: Fix RGMII TX clock delay setup
In-Reply-To: <54f5bd21-766d-d9de-3b15-a01fd5ee6035@free.fr> (Mason's message
 of "Thu, 20 Jul 2017 14:33:00 +0200")
References: <b332dc3e-4478-e34b-2b3f-226aad8a11d4@sigmadesigns.com>
 <61b71d12-4e3a-edbe-1d69-c66e7cf46d8e@sigmadesigns.com>
 <yw1xzic0qrcg.fsf@mansr.com>
 <001a7afd-364d-359e-1478-e057c9083f73@free.fr>
 <d8121f82-dffd-22c7-1209-a3c2329703e5@gmail.com>
 <05cbc32e-a4af-1c81-128b-bc5d2206d24a@free.fr>
 <bf484952-15ae-b385-6b54-4d07b3bc2b29@gmail.com>
 <54f5bd21-766d-d9de-3b15-a01fd5ee6035@free.fr>
Message-ID: <yw1xmv7zqo3e.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> I will look for an inter-packet gap knob and FCS error counter.

There is an FCS error counter.  Use "ethtool -S" and look for
rx_bad_fcs_frames.  Reading the stats counters automatically resets
them to zero.

-- 
M?ns Rullg?rd
