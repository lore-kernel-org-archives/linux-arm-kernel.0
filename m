From: stefan@agner.ch (Stefan Agner)
Date: Mon, 06 Jun 2016 10:47:40 -0700
Subject: [PATCH 3/5] regulator: rn5t618: add RN5T567 PMIC support
In-Reply-To: <20160606173539.GC7510@sirena.org.uk>
References: <20160605001749.4062-1-stefan@agner.ch>
 <20160605001749.4062-5-stefan@agner.ch>
 <20160606173539.GC7510@sirena.org.uk>
Message-ID: <c6edd422420533d16c076ad5e721e549@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-06-06 10:35, Mark Brown wrote:
> On Sat, Jun 04, 2016 at 05:17:47PM -0700, Stefan Agner wrote:
>> Extend the driver to support Ricoh RN5T567. Support the additional
>> DCDC and slightly different voltage range of LDORTC1.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks Mark.

Do you have an idea how the patchset should be handled with the
dependent dt change in patch 1?

--
Stefan
