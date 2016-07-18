From: john@phrozen.org (John Crispin)
Date: Mon, 18 Jul 2016 14:19:08 +0200
Subject: [PATCH V9 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <20160718121638.GT30372@sirena.org.uk>
References: <1468843741-59637-1-git-send-email-john@phrozen.org>
 <1468843741-59637-2-git-send-email-john@phrozen.org>
 <20160718121638.GT30372@sirena.org.uk>
Message-ID: <2cfa2662-29af-5c9a-7e74-bdb0c22b83c3@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/07/2016 14:16, Mark Brown wrote:
> On Mon, Jul 18, 2016 at 02:09:01PM +0200, John Crispin wrote:
> 
>> Changes in V9
>> * drop compatible string from devicetree
> 
> Are you sure?
> 
>> +static const struct of_device_id mt6323_of_match[] = {
>> +	{ .compatible = "mediatek,mt6323-regulator", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, mt6323_of_match);
>> +
>> +static struct platform_driver mt6323_regulator_driver = {
>> +	.driver = {
>> +		.name = "mt6323-regulator",
>> +		.of_match_table = of_match_ptr(mt6323_of_match),



i was in the wrong folder while sending the patch so i ended up sending
the wrong patch with the wrong email account. sorry about the noise V10
coming up :/
