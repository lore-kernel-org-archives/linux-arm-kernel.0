From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 26 Nov 2015 18:39:28 +0100
Subject: [PATCH 04/13] net: mvneta: enable suspend/resume support
In-Reply-To: <87k2p67wqz.fsf@free-electrons.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <1448178839-3541-5-git-send-email-mw@semihalf.com>
 <87k2p67wqz.fsf@free-electrons.com>
Message-ID: <CAPv3WKdT2WFQy_UksaoRMpd7hwUMAgDXz3sVRjNggEUagyjCxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,


>> +     /* Reset link status */
>> +     pp->link = 0;
>> +     pp->duplex = -1;
>> +     pp->speed = 0;
>> +
>
> Would it be possible to add a kind of mvneta_port_power_down(pp,
> pp->phy_interface) here ? It would allow to save power in standby mode
> too.
>

Sure, I'll try it.

Best regards,
Marcin
