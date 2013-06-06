From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Jun 2013 09:58:14 -0600
Subject: Tegra baseline test results for v3.10-rc1
In-Reply-To: <alpine.DEB.2.02.1306060421250.15042@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306050558430.13098@utopia.booyaka.com>
 <51AF5698.5050106@wwwdotorg.org>
 <alpine.DEB.2.02.1306060421250.15042@utopia.booyaka.com>
Message-ID: <51B0B196.3040400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 10:34 PM, Paul Walmsley wrote:
> Hi Stephen,
> 
> thanks very much for the review -
> 
> On Wed, 5 Jun 2013, Stephen Warren wrote:
> 
>> On 06/04/2013 11:59 PM, Paul Walmsley wrote:
>>>
>>> Here are some basic Tegra test results for Linux v3.10-rc1.
>>> Logs and other details at:
...
>> I'm curious what the difference is between the "t33beaver" and
>> "tegra30-beaver" path entries is, in the following URL:
>>
>> http://www.pwsan.com/tegra/testlogs/test_v3.10-rc1/20130519152115/boot/t33beaver/tegra30-beaver/
>>
>> It might be better to call this board just "tegra30-beaver" for
>> consistency with other upstream tools like cbootimage-configs and the
>> DTB filename.
> 
> In the boot test environment here, "t33beaver" uniquely identifies the 
> board, while "tegra30-beaver" identifies the DTB used to boot it.  
> So if an alternate DTB were used, the boot test path would be:
> 
> ../boot/t33beaver/tegra30-beaver-alternate/
> 
> If it's important to you, I'll change it.  Otherwise, I'd prefer not to 
> call the board 'tegra30-beaver' -- mostly to avoid confusing myself 
> between the board name and the DTB name :-)

Could you name the directories
.../boot/board-tegra30-beaver/tegra30-beaver.dtb/ or
../boot/board-tegra30-beaver/tegra30-beaver-alternate.dtb/? I'd really
love not to propagate a different set of names for the boards.
