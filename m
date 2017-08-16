From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 17:20:48 +0200
Subject: [PATCH] firmware: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-21-robh@kernel.org>
References: <20170718214339.7774-21-robh@kernel.org>
Message-ID: <CAK8P3a0o7roVft-C6op3CU3_yMgphQPEJTsx0cdeB4+S76dkew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org

Applied to next/drivers with Sudeep's ack, thanks.

      Arnd
