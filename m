From: cjb@laptop.org (Chris Ball)
Date: Tue, 19 Mar 2013 13:11:36 -0400
Subject: [GIT PULL] ARM: tegra: DT-related fixes needed by the MMC tree
In-Reply-To: <51489146.9090109@wwwdotorg.org> (Stephen Warren's message of
 "Tue, 19 Mar 2013 10:24:38 -0600")
References: <1363034651-21472-1-git-send-email-swarren@wwwdotorg.org>
 <51489146.9090109@wwwdotorg.org>
Message-ID: <87obeftiuv.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Mar 19 2013, Stephen Warren wrote:
> On 03/11/2013 02:44 PM, Stephen Warren wrote:
>> In order to convert the Tegra MMC driver to using mmc_of_parse(), some
>> bugs in the Tegra device-tree content need to be fixed first; it's
>> currently wrong but unused, and mmc_of_parse() causes that data to be
>> used for the first time.
>
> Chris, I don't see this pull request nor the followup patch in the
> mmc-next branch yet. Are you still planning on pulling it in? Let me
> know if you need me to resend them. Thanks.

Thanks for the reminder, I've pulled your tag and the followup patch
into mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
