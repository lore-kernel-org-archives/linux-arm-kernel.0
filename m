From: carlo@caione.org (Carlo Caione)
Date: Thu, 6 Mar 2014 12:32:21 +0100
Subject: [linux-sunxi] Re: [PATCH 0/7] mfd: AXP20x: Add support for AXP202
 and AXP209
In-Reply-To: <5318568E.4040405@redhat.com>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <53121151.9050804@redhat.com>
 <CAOQ7t2ae35E-eiQW4DFspdTe3H7AWGzRpw4B_1t27p0OSkX_Uw@mail.gmail.com>
 <53123507.6020607@redhat.com> <531782DF.6090209@redhat.com>
 <CAOQ7t2bx1u73kxQVa3AeQ-hZ9nP3GSukEdXk-jRNwbT0vUH4+A@mail.gmail.com>
 <531848E5.4050704@redhat.com>
 <CAOQ7t2aVchEe0Mtbp8KV4ZTzE_0C0BeO15S7aF4nJx6PaBno=w@mail.gmail.com>
 <5318568E.4040405@redhat.com>
Message-ID: <CAOQ7t2bs9-FSD9PGakwU4uJacjPd9Ss8Qv3wGjeeZt_igOyhrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 6, 2014 at 12:05 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Ah, yes but that is before you added all the regulators, which are a fixed part
> of the chip. Once you get long dts bits like that having a dtsi file makes a lot
> of sense IMHO. Note that the part of the dts this was discussing is actually the part
> I did not put in the dtis, since it can vary per board :)

Oook, now it makes sense. The idea was to integrate axp20x.dtsi at a
later time, but probably I was misunderstood. Thank you for clarifying
it.
I'll put axp20x.dtsi back in v2.

Thanks,

-- 
Carlo Caione
