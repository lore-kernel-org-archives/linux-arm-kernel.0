From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 19:38:41 +0000
Subject: [PATCH] icst307: Add missing increment
In-Reply-To: <4AE61590.2030603@gmail.com>
References: <4AE61590.2030603@gmail.com>
Message-ID: <20091027193841.GB22412@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2009 at 10:33:04PM +0100, Roel Kluin wrote:
> Without this increment the loop can only break if it does in the
> first iteration.

Ok.
