From: horia.geanta@nxp.com (=?iso-8859-2?Q?Horia_Geant=E3?=)
Date: Thu, 16 Mar 2017 14:13:52 +0000
Subject: [RFC 0/7] crypto: caam - add Queue Interface (QI) support
References: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
 <20170316084249.GB11653@gondor.apana.org.au>
Message-ID: <DB4PR04MB0847AD372AFF9510CDCA3ECD98260@DB4PR04MB0847.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2017 10:43 AM, Herbert Xu wrote:
> On Fri, Mar 03, 2017 at 04:52:06PM +0200, Horia Geant? wrote:
>> The patchset adds support for CAAM Queue Interface (QI), the additional
>> interface (besides job ring) available for submitting jobs to the engine
>> on platforms having DPAA (Datapath Acceleration Architecture).
>>
>> Patches 1-4 are QMan dependencies.
>> I would prefer to take them through the crypto tree,
>> but I am open to suggestions.
>>
>> Patch 5 adds a missing double inclusion guard in desc_constr.h.
>>
>> Patch 6 adds the caam/qi job submission backend.
>>
>> Patch 7 adds algorithms (ablkcipher and authenc) that run on top
>> of caam/qi. For now, their priority is set lower than caam/jr.
> 
> I'm fine with the crypto bits.
> 
Herbert,

Thanks for the review.
Should I submit formally, i.e. without the [RFC] prefix?

Scott, Roy,

Do you have any comments wrt. soc/qman patches or with them going
through the crypto tree?

Thanks,
Horia
