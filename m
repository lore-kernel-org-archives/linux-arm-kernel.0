From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 10 Aug 2012 10:51:03 -0600
Subject: [PATCH V3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <1344017330-29306-1-git-send-email-swarren@wwwdotorg.org>
References: <1344017330-29306-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50253BF7.1030000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 12:08 PM, Stephen Warren wrote:
> Seaboard uses a TPS6586x regulator. Instantiate this, and hook up a
> couple of fixed GPIO-controlled regulators too.

Applied to for-3.7/dt.
