From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jun 2014 18:00:33 +0300
Subject: [PATCH] clk: define and export __clk_get_debug for providers
In-Reply-To: <1403788921-7963-1-git-send-email-pdeschrijver@nvidia.com>
References: <1403788921-7963-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20140626150033.GH3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 03:22:01PM +0200, Peter De Schrijver wrote:
> Define and export a new function __clk_get_debug which returns the debugfs
> directory entry pointer. This can be used by clock providers to add debugfs
> entries which are not related to a specific clock type. Examples include the
> ability to measure the rate of a clock. It can also be used by modules to
> create new debugfs entries. This is useful if you want to expose features
> for testing which can potentially cause system instability such as allowing
> to change a clock's rate from userspace.

Oops. Ignore this :)
