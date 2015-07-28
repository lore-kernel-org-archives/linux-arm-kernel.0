From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 28 Jul 2015 17:29:14 +0200
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <20150728150929.233B56C80391@dd34104.kasserver.com>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
 <55B5E6DB.8020009@redhat.com>
 <20150727120918.191F76C82FB4@dd34104.kasserver.com>
 <55B62768.6040403@redhat.com>
 <20150728124911.GA2564@lukather><55B790BA.5000509@redhat.com>
 <20150728150929.233B56C80391@dd34104.kasserver.com>
Message-ID: <55B79FCA.7070907@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/28/2015 05:09 PM, Timo Sigurdsson wrote:
> Hi,
>
> Hans de Goede schrieb am 28.07.2015 16:24:
>> I've no problem with Timo submitting a cleaned up version of his
>> patch and you taking that instead. I just wanted to point out that
>> I do have a similar patch pending.
>
> Ok, I will do that. It might take a couple of days, though, as I will be moving
> moving in the next few days as well.
>
> However, another question first then: What maximum voltage for the dcdc2
> regulator should we use then? You used 1.5V, I used 1.45V so far, which is what
> Cubieboard 2 and Cubietruck use.
>
> But after the discussion about overvoltaged settings, I'm wondering whether we
> should limit the regulartor (and not only the opp) to 1.40V as well? Or is
> 1.45V ok for everybody here?

The datasheets lists a max cpu-voltage of 1.40V, so lets stick with that.

Regards,

Hans
