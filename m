From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 06 Mar 2014 11:07:33 +0100
Subject: [linux-sunxi] Re: [PATCH 0/7] mfd: AXP20x: Add support for AXP202
 and AXP209
In-Reply-To: <CAOQ7t2bx1u73kxQVa3AeQ-hZ9nP3GSukEdXk-jRNwbT0vUH4+A@mail.gmail.com>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>	<53121151.9050804@redhat.com>	<CAOQ7t2ae35E-eiQW4DFspdTe3H7AWGzRpw4B_1t27p0OSkX_Uw@mail.gmail.com>	<53123507.6020607@redhat.com>	<531782DF.6090209@redhat.com>
 <CAOQ7t2bx1u73kxQVa3AeQ-hZ9nP3GSukEdXk-jRNwbT0vUH4+A@mail.gmail.com>
Message-ID: <531848E5.4050704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/05/2014 09:46 PM, Carlo Caione wrote:
> On Wed, Mar 5, 2014 at 9:02 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> So I've added your patches to my sunxi-devel tree and they work as advertised :)
> 
> Thank you for keeping the tree updated :)
> 
>> I've also added dt support for the axp209 to the cubietruck dts file, to avoid
>> things becoming a copy and paste fest I've introduced a new axp209.dtsi file,
>> as well as did some fixes to the existing sun?i-a*.dtsi files, see my tree here:
>> https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-devel
> 
> That was also my idea (creating a new axp20x.dtsi) but it has been
> turned down by Maxime and Lee

Hmm, do you have a pointer to the mailinglist discussion about this ?

Regards,

Hans
