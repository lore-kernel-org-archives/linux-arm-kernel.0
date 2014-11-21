From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Nov 2014 18:13:32 +0000
Subject: [PATCH 3/3] regulator: rpm: add support for RPM-controller SMB208
In-Reply-To: <1416512485-7292-4-git-send-email-joshc@codeaurora.org>
References: <1416512485-7292-1-git-send-email-joshc@codeaurora.org>
 <1416512485-7292-4-git-send-email-joshc@codeaurora.org>
Message-ID: <20141121181332.GY3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 01:41:25PM -0600, Josh Cartwright wrote:
> The IPQ8064 reference boards make use of SMB208 regulators which are
> controlled by RPM.  Implement support for these regulators in the RPM
> regulator driver.

I'm missing both patches 1-3 and the cover letter, what's the story
with the series - are there interdependencies?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/64c82591/attachment-0001.sig>
