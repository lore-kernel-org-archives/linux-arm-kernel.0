From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 9 Nov 2017 23:09:25 -0200
Subject: [PATCH] ARM: dts: vf610-zii-dev-c: Fix switch EEPROM size
In-Reply-To: <20171110010318.GA32303@lunn.ch>
References: <1510271336-30769-1-git-send-email-andrew@lunn.ch>
 <CAOMZO5DvJAAh_eNnHF4sOjPuzqkKxkenuSDzG7ppaEMh7puFBQ@mail.gmail.com>
 <20171110010318.GA32303@lunn.ch>
Message-ID: <CAOMZO5B=koVbz0NfUV4d_m7EBdC+14duaMD2awJjoho0T9vMuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 9, 2017 at 11:03 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Fabio
>
>> vf610-zii-dev-rev-b.dts also uses 512.
>>
>> Should it be also changed or is it correct for the rev-b?
>
> Rev-B is correct. Rev-C has a newer generation of Ethernet switch,
> which has a little microcontroller in it. That microcontroller gets
> its code from the EEPROM. So a bigger EEPROM is required.

Thanks for the clarification:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
