From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 14:51:16 -0800
Subject: [PATCH] ARM: hisi: don't select SMP
In-Reply-To: <1391205990-22506-1-git-send-email-robherring2@gmail.com>
References: <1391205990-22506-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140131225116.GA6284@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 04:06:30PM -0600, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> SMP is a user configurable option, not a hardware feature and should not
> be selected.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Yep, you're right. applied to fixes.

-Olof
