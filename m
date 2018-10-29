From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Oct 2018 11:11:03 +0100
Subject: [PATCH 0/9] serial: Add Tegra Combined UART driver
In-Reply-To: <85092b49-2b62-bd76-05a3-521415835b6e@nvidia.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <85092b49-2b62-bd76-05a3-521415835b6e@nvidia.com>
Message-ID: <20181029101103.GA26393@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 11:04:06AM +0200, Pekka Pessi wrote:
> Hi Thierry,
> 
> What is the use case for the mailbox driver? What kind of entity will be
> there consuming sent messages and sending messages to kernel?

This is currently only used for the TCU. I'm sure there could be other
cases, but we support none of the upstream at the moment. Are you aware
of any others that we need to take into account?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/dd709c6d/attachment.sig>
