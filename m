From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 10 Nov 2017 02:03:18 +0100
Subject: [PATCH] ARM: dts: vf610-zii-dev-c: Fix switch EEPROM size
In-Reply-To: <CAOMZO5DvJAAh_eNnHF4sOjPuzqkKxkenuSDzG7ppaEMh7puFBQ@mail.gmail.com>
References: <1510271336-30769-1-git-send-email-andrew@lunn.ch>
 <CAOMZO5DvJAAh_eNnHF4sOjPuzqkKxkenuSDzG7ppaEMh7puFBQ@mail.gmail.com>
Message-ID: <20171110010318.GA32303@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

> vf610-zii-dev-rev-b.dts also uses 512.
> 
> Should it be also changed or is it correct for the rev-b?

Rev-B is correct. Rev-C has a newer generation of Ethernet switch,
which has a little microcontroller in it. That microcontroller gets
its code from the EEPROM. So a bigger EEPROM is required.

    Andrew
