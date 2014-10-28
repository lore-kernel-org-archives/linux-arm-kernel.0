From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Oct 2014 21:55:49 +0100
Subject: [PATCH v3 1/2] Documentation: dmaengine: Move the current doc to a
 folder of its own
In-Reply-To: <1414529750-14431-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414529750-14431-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1414529750-14431-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the current client-side documentation to a subfolder to prepare the
introduction of a provider-side API documentation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/{dmaengine.txt => dmaengine/client.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{dmaengine.txt => dmaengine/client.txt} (100%)

diff --git a/Documentation/dmaengine.txt b/Documentation/dmaengine/client.txt
similarity index 100%
rename from Documentation/dmaengine.txt
rename to Documentation/dmaengine/client.txt
-- 
2.1.1
