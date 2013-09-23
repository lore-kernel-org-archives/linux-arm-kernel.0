From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 14:55:50 -0600
Subject: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <5239A0ED.6010606@st.com>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-2-git-send-email-maxime.coquelin@st.com>
 <5239A0ED.6010606@st.com>
Message-ID: <5240AAD6.7050002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 06:47 AM, Gabriel FERNANDEZ wrote:
> On 18/09/2013 12:01, Maxime COQUELIN wrote:
>> This patch adds support to SSC (Synchronous Serial Controller)
>> I2C driver. This IP also supports SPI protocol, but this is not
>> the aim of this driver.
>>
>> This IP is embedded in all ST SoCs for Set-top box platorms, and
>> supports I2C Standard and Fast modes.
> ... [entire patch quoted for a one-line comment] ...

Please trim down the patch so you only quote relevant lines. Quoting the
entire patch for a 1-line comment makes people wast time searching for
your reply.
