From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jan 2013 13:07:26 +0000
Subject: [PATCH 2/6] arm: mvebu: Enable USB controllers on Armada 370
 evaluation board
In-Reply-To: <1358243670-11935-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358243670-11935-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201301151307.26665.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 January 2013, Ezequiel Garcia wrote:
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The patches look good, but when you have four trivial patches
doing the same thing in different files, and you decide that it's
not worth writing a changelog for them, they should probably
go into a single patch.

	Arnd
